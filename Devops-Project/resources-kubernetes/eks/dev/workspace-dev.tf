terraform { 
  cloud { 
    
    organization = "Devops-Project-Django101" 

    workspaces { 
      name = "devops-kubernetes-development" 
    } 
  } 
}