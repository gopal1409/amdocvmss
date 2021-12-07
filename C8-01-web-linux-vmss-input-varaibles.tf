variable "web_vmss_inbound_ports" {
  description = "Web vmss nsg inbound port"
  type = list(string)
  default = [22,80,443]
}