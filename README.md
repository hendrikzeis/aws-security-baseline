# aws-security-baseline

Ein Lernprojekt, in dem ich ein AWS-Konto mit Terraform Schritt für Schritt absichere. Ziel ist, Infrastruktur reproduzierbar, nachvollziehbar und mit Blick auf Sicherheit aufzubauen.

## Status

In Arbeit. Aktuell umgesetzt:
- Provider-Konfiguration mit SSO-Profil (kein Access Key im Code)
- Verschlüsselter S3-Bucket als Log-Ziel

Geplant: CloudTrail, Versionierung und Zugriffsschutz für den Log-Bucket, Security-Checks mit Checkov.

## Aufbau

| Datei | Inhalt |
|---|---|
| `versions.tf` | Terraform- und Provider-Version |
| `main.tf` | Provider-Konfiguration und Ressourcen |
| `.gitignore` | Schließt State-Dateien und lokale Caches aus |

## Entscheidungen

- **SSO statt Access Keys:** Kurzlebige Zugangsdaten, keine langfristigen Schlüssel im Code.
- **AES256 statt KMS:** Standardverschlüsselung von S3, kostenlos. Für Logs mit höheren Anforderungen würde ich einen KMS-Schlüssel mit eigener Key Policy nutzen.
- **Lokaler State:** Lernumgebung. Im Team gehört der State in ein Remote-Backend mit Locking, siehe Plan.
- **State nicht im Repo:** `terraform.tfstate` kann sensible Werte enthalten und wird deshalb ignoriert.

## Voraussetzungen

- Terraform >= 1.17
- AWS CLI v2
- Ein AWS-Konto mit IAM Identity Center (SSO)
- Profil `cantrill-lab` in `~/.aws/config`

## Ausführen

```bash
aws sso login --profile cantrill-lab
terraform init
terraform plan
terraform apply
```

Kosten: Ein leerer Bucket ist praktisch kostenlos. Speicher- und Logkosten entstehen erst mit Daten.

## Aufräumen

```bash
terraform destroy
```