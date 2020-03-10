resource "digitalocean_droplet" "jenkins" {
    count = var.jenkins_count
    name = "${count.index + 1}" > 9 ? "${var.region}-jenkins-node-${count.index + 1}" : "${var.region}-jenkins-0${count.index + 1 }"
    image = var.image
    region = var.region
    size = var.size
    private_networking = true
    ssh_keys = [ 
        data.digitalocean_ssh_key.malikiah.id
    ]
    tags = [
        "jenkins",
        var.image,
    ]
    
}