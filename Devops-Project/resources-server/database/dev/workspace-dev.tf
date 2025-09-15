terraform { 
  cloud { 
    
    organization = "Devops-Project-Django101" 

    workspaces { 
      name = "app-database-development" 
    } 
  } 
}