terraform { 
  cloud { 
    
    organization = "Devops-Project-Django101" 

    workspaces { 
      name = "infra-secrets-development" 
    } 
  } 
}