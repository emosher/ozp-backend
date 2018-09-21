## Interested in becoming a contributor? 
Fork the code for this repository. Make your changes and submit a pull request. The Ozone team will review your pull request and evaluate if it should be part of the project. For more information on the patch process please review the Patch Process at https://ozone.nextcentury.com/patch_process.

# ozp-backend
Django-based backend API for the OZONE Platform (OZP). For those who just want
to get OZP (Center, HUD, Webtop, IWC) up and running, see the
[quickstart](https://github.com/ozoneplatform/ozp-ansible#quickstart) of the [ozp-ansible](https://github.com/ozoneplatform/ozp-ansible) project.

## Background
ozp-backend replaces [ozp-rest](https://github.com/aml-development/ozp-rest)
as the backend for Center, HUD, Webtop, and IWC. Notable differences include:
* Python vs. Java/Groovy
* Django, Django Rest Framework vs. Grails, JAX-RS
* Postgres vs. MySQL
