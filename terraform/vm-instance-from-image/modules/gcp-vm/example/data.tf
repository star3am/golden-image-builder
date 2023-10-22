data "external" "myipaddress" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}
