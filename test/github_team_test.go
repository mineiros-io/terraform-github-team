package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

var githubOrganization, githubToken string

func init() {
	githubOrganization = os.Getenv("GITHUB_ORGANIZATION")
	githubToken = os.Getenv("GITHUB_TOKEN")

	if githubOrganization == "" {
		panic("Please set a github organization using the GITHUB_ORGANIZATION environment variable.")
	}

	if githubToken == "" {
		panic("Please set a github token using the GITHUB_TOKEN environment variable.")
	}
}

func TestGithubTeam(t *testing.T) {
	t.Parallel()

	repositoryA := fmt.Sprintf("a-repository-%s", random.UniqueId())
	repositoryB := fmt.Sprintf("B-Repository-%s", random.UniqueId())
	teamName := fmt.Sprintf("team-%s", random.UniqueId())

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "public-repositories-with-team",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"team_name":         teamName,
			"a-repository-name": repositoryA,
			"b-repository-name": repositoryB,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndPlan(t, terraformOptions)
	terraform.ApplyAndIdempotent(t, terraformOptions)
}
