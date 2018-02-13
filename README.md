# sensu-terraform-demo
Demo of using Terraform to build a Sensu environment on DigitalOcean

## Using this code
Before using this code you must register for an account at [http://digitalocean.com](http://digitalocean.com), add funds into the account & generate an API token.

You will then also need to install Terraform, if using MacOS you can do this easily with `brew`:

`brew install terraform`

Once you have a DigitalOcean account, DigitalOcean API key and Terraform is installed on your workstation you are ready to proceed.

After cloning the repo you can first validate the code using Terraform:

`terraform validate`

Then generate a Terraform plan:

`terraform plan -var 'do_token=your_do_api_token_here' -out terraform.plan`

Lastly use Terraform to now apply the generated plan if the output looks fine:

`terraform apply terraform.plan`

Once you have finshed with this environment, use Terraform to tear down the environment:

`terraform destroy`

You will be prompted to enter `yes` once happy it is destroying the desired resources. You can force this on the command line with `-force`:

`terraform destroy -force`

## Slides
<iframe src="https://docs.google.com/presentation/d/e/2PACX-1vTSVBmij3GvSgR-dwfrHefMLvUVaNpRlolJGBOY_HJJJp19yluHOZirB__xOoOnIY6Vc86Ozn0qDjMA/embed?start=false&amp;loop=false&amp;delayms=3000" frameborder="0" width="960" height="569" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>

