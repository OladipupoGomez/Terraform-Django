terraform { 
  cloud { 
    
    organization = "Devops-Project-Django101" 

    workspaces { 
      name = "devops-servers-development" 
    } 
  } 
}