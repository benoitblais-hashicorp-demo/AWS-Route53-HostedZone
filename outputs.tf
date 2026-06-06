output "name_servers" {
  description = "A list of name servers for the hosted zone."
  value       = data.aws_route53_zone.main.name_servers
}

output "zone_id" {
  description = "The ID of the hosted zone."
  value       = data.aws_route53_zone.main.zone_id
}

output "zone_name" {
  description = "The name of the hosted zone."
  value       = data.aws_route53_zone.main.name
}