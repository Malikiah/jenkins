data "template_file" "inventory" {
    template =  file("./templates/inventory.tpl")

    vars = {
        ssh_user = var.ssh_user
        ssh_key = var.ssh_key
        jenkins_nodes = join("\n", digitalocean_droplet.jenkins.*.ipv4_address),
        domain = var.domain,
        service-port = var.service-port,
    }

    depends_on = [
        digitalocean_droplet.jenkins,
    ]
}

resource "null_resource" "cmd" {
    triggers = { 
        template_rendered = data.template_file.inventory.rendered
    }
    provisioner "local-exec" {
        command = "echo '${data.template_file.inventory.rendered}' > ansible/inventory"
    }
}