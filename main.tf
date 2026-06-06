data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "caa" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "CAA"
  ttl     = 300
  records = [
    "0 issue \"letsencrypt.org\"",
    "0 issuewild \"letsencrypt.org\"",
    "0 issue \"globalsign.com\"",
    "0 issuewild \"globalsign.com\""
  ]
}

resource "aws_route53_record" "acme_challenge" {
  for_each = var.acme_challenges

  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${each.key}.${var.domain_name}"
  type    = "TXT"
  ttl     = 60
  # Provide all tokens in the array as a single multi-value TXT record
  records = each.value
}