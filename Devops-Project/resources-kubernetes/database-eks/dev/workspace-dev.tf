terraform { 
  cloud { 
    
    organization = "Devops-Project-Django101" 

    workspaces { 
      name = "eks-database-development" 
    } 
  } 
}