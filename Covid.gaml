/**********************************************************************************************************************************
 *  COVID19 Math - Model
 *  Author: Selain Kasereka
 *  Purpose: Research paper with Prof Ngoie (ISP-Mbanza)
 *  Description: Dynamics of a COVID-19 Outbreak Model with Hospitalized and Home-care Patients Groups, 
 * The dynamic of the disease is managed by ODE using rk4 method. The model is compartmental one, it has 7 compartments.
 **********************************************************************************************************************************/

model Covid

global {
	
// Declaration of global variables 

// Model parameters	
	float Gamma; // Recruitment in S
	float mu1; // Natural mortality rate of general population
	float mu2; // Mortality rate for I people
	float pi1; // Mortality rate for H people
	float pi2; // Mortality rate for M people
	float alpha; // Contact rate
	float beta; // transmission rate from E to I
	float gamma; // Rate of a I people to became H (1-gamma is from I to M)
	float theta1; // Rate of people from H to M
	float theta2; // Rate of people from M to H
	float phi1; // Recovered rate from H to R
	float phi2; // Recovered rate from M to R
	float epsilon1; // Rate of becoming S from H
	float epsilon2; // Rate of becoming S from M
	//float p; //proportion
	
// Other parameters
	int test <- 0; // break the loop
	float stepI; // discrétisation step for the resolution of ODE using rk4 method.
	
//Population
	int S_people <- 150 min: 50 max:100000; //Number of susceptible individuals
    int E_people <- 0 min: 0 max:100000; //Number of exposed individuals
    int I_people <- 2 min: 1 max:100000; //Number of infected/infectious individuals
    int H_people <- 0 min: 0 max:100000; //Number of hospitalized individuals 
    int M_people <- 0 min: 0 max:100000; //Number of people to be cared at home.
    int D_people <- 0 min: 0 max:100000; //Number of deaths 
    int R_people <- 0 min: 0 max:100000; //Number of recovered individuals
    int Iinit <- 2 min: 2 max: 100000; //The initial number of infectious individuals in I
    
// Calcuation of N, the total population   
        float N <- float(S_people + E_people + I_people + H_people + M_people + D_people + R_people); // Total population

// Calcuation of R0
		float w1 <- mu1 + epsilon1 + phi1 + pi1 + theta1;
		float w2 <- mu1 + epsilon2 + phi2 + pi2 + theta2;
		float R0 <- (alpha * Gamma * beta * (w1 * w2 + gamma * w2 + gamma * theta1))/(mu1 * (mu1 + beta) * (mu1 + mu2 + 1) * w1 * w2);
 
 // calculation of sensytivity indices 
 		
		float I_beta<- mu1/(mu1 + beta);
		float I_gamma <- gamma*(w2 + theta1)/(w1*w2 + gamma*w2+gamma*theta1);
		float I_thata1<- -(gamma*theta1*(w1 + w2 + theta1))/ (w1*w2 + gamma*w2+gamma*theta1);
		float I_theta2<-  -(gamma*theta1*theta2)/(w1*w2 + gamma*w2+gamma*theta1);
		float I_pi1 <- -(gamma*pi1*(w2 + theta1))/(w1*(w1*w2+gamma*w2+gamma*theta1));
		float I_pi2<- -(gamma*theta1*pi2)/(w1*w2 + gamma*w2+gamma*theta1);
		float I_phi1 <- -(gamma*phi1*(w2+theta1)) /(w1*(w1*w2+gamma*w2+gamma*theta1));
		float I_phi2 <- -(gamma*theta1*phi2) /(w1*w2 + gamma*w2+gamma*theta1);
		float A<- w1*w2*(w1 + w2 + gamma)*(mu1 + beta)*(mu1 + mu2+1)-(3*mu2 +2*mu2+ 2*beta + 2)*(mu1 + mu2); //Needed to compute I_mu1
		float B<- w1*w2*(mu1 + beta)*(mu1 + mu2 + 1)*(w1*w2 + gamma*w2 + gamma*theta1);//Needed to compute I_mu1
		float I_mu1<- (A*mu1)/B;
		float I_mu2 <- -(mu2)/(mu1+mu2+1) /(w1*(w1*w2+gamma*w2+gamma*theta1));
		float I_epsilon1 <- -(gamma*epsilon1*(w2 + theta1));
		float I_epsilon2 <- -(gamma*theta1*epsilon2) /(w1*w2 + gamma*w2+gamma*theta1);
     
	
	init{
		
//Create the math model
		create COVID_Maths {
			S <- float(S_people);
			E <- float(E_people);
			I <- float(I_people);
			H <- float(H_people);
			M <- float(M_people);
			D <- float(D_people);
			R <- float(R_people);
		}		 
	}

// Create loop to manage the time of the simulation
reflex pause_simulation when: (cycle = 50) {
					do pause ;
			}
			
reflex save_data when: every(1#cycle){
//save the following text into the csv  file. Note that each time the save statement is used, a new line is added at the end of the file.
//save [cycle,first(COVID_Maths).S,first(COVID_Maths).E,first(COVID_Maths).I,first(COVID_Maths).H,first(COVID_Maths).M,first(COVID_Maths).D,first(COVID_Maths).R] to: "../results/SituationGenerale.csv" type:"csv" rewrite: false;
save [cycle, first(COVID_Maths).E, first(COVID_Maths).I, first(COVID_Maths).M] to: "../results/AvecBeta09.csv" type:"csv" rewrite: false;
		} 
							
}

// create the species of the created Math Model	
species COVID_Maths{

    float t;    
	float S <- N - E -I - H - M - D - R; 
	float E;
	float I <-float(Iinit);
	float H;
	float  M;
	float D;
	float R;
	
 // definition de l'equation du modele SIR  
			
	equation Covid_19 { 
		    diff(S,t) = Gamma - mu1 * S - alpha * S * I + epsilon1 * H + epsilon2 * M;
			diff(E,t) = alpha * S * I - mu1*E - beta*E ;
			diff(I,t) = beta * E - mu1 * I - mu2 * I - gamma * I - I + gamma * I;
			diff(H,t) = gamma*I + theta2*M - (mu1 + epsilon1 + phi1 + pi1 + theta1)*H;
			diff(M,t) = (1-gamma)*I + theta1*H - (mu1 + epsilon2 + phi2 + pi2 + theta2)*M;
			diff(R,t) = phi1*H + phi2*M - mu1*R;
			diff(D,t) = pi1*H + pi2*M;
			
			}
	reflex solving {
		
		solve Covid_19 method: "rk4" step_size: stepI;
		
		// Display the values of R0 in consol		
		test<-test + 1;
		if(test=1){
		write("R0 est de : "+R0); 
		// Display the sensitives index values respect to all parameters in consol	
		write("--------------------------------"); 
		write("I_beta est de : "+I_beta);
		write("--------------------------------"); 
		write("I_gamma est de : "+I_gamma);
		write("--------------------------------"); 
		write("I_theta1 est de : "+I_thata1);
		write("--------------------------------"); 
		write("I_theta2 est de : "+I_theta2);
		write("--------------------------------"); 
		write("I_pi1 est de : "+I_pi1);
		write("--------------------------------"); 
		write("I_pi2 est de : "+I_pi2);
		write("--------------------------------"); 
		write("I_phi1 est de : "+I_phi1);
		write("--------------------------------"); 
		write("I_phi2 est de : "+I_phi2);
		write("--------------------------------"); 
		write("I_mu1 est de : "+I_mu1);
		write("--------------------------------"); 
		write("I_mu2 est de : "+I_mu2);
		write("--------------------------------"); 
		write("I_epsilon1 est de : "+I_epsilon1);
		write("--------------------------------"); 
		write("I_epsilon2 est de : "+I_epsilon2);	
			}

		}

	}
	
//Create the experiement that will allows us to display all output
experiment EXECUTE_Model type: gui {
	
// Define parameters for user interface	
	//Population for users
	parameter 'Number of Susceptible: S' type: int var: S_people category: "Initial population";
	parameter 'Number of Exposed : E' type: int var: E_people category: "Initial population";
	parameter 'Number of Infected: I' type: int var: I_people category: "Initial population";
	parameter 'Initial number of Infectious : Iinit' type: int var: Iinit category: "Initial population";
	
// Parametr for users
	parameter 'Discrétisation steps for RK4' type: float var: stepI <- 0.01 category: "Parameters"; // stepI
	parameter 'Recrutment' type: float var: Gamma <- 0.009 category: "Parameters"; //Recruitment in S
	parameter 'Mortality rate of general population' type:  float var: mu1  <- 0.00576 category: "Parameters"; // Mortality rate of general population
	parameter 'Mortality rate from I' type:  float var: mu2  <- 0.196 category: "Parameters"; // Mortality rate of general population
	parameter 'transmission rate' type: float var: beta <- 0.9 category: "Parameters"; // Transmission rate
    parameter 'Mortality rate for H people' type: float var: pi1 <- 0.196 category: "Parameters"; // Mortality rate for H people
    parameter 'Mortality rate for M people' type: float var: pi2 <- 0.196 category: "Parameters"; // Mortality rate for M people
    parameter 'Contact rate' type: float var: alpha <- 0.9 category: "Parameters"; // Contact rate
    parameter 'Rate of a I people to became H ' type: float var: gamma <- 1.0 category: "Parameters"; // Rate of a I people to became H 
    parameter 'Rate of people from H to M ' type: float var: theta1 <- 0.396 category: "Parameters"; // Rate of people from H to M
    parameter 'Rate of people from M to H ' type: float var: theta2 <- 0.0396 category: "Parameters"; // Rate of people from M to H
    parameter 'Recovered rate from H to R ' type: float var: phi1 <- 0.900 category: "Parameters"; // Recovered rate from H to R
    parameter 'Recovered rate from M to R ' type: float var: phi2 <- 0.00000625 category: "Parameters"; // Recovered rate from H to R
  	parameter 'Rate of becoming S from H ' type: float var: epsilon1 <- 0.1 category: "Parameters"; // Rate of becoming S from H
    parameter 'Rate of becoming S from M ' type: float var: epsilon2 <- 0.1 category: "Parameters"; // Rate of becoming S from M
	 
	output { 
		
// Graphic camambert	 
//	display COVID_line refresh: every(#sec) {
//			chart "Covid Model1" type: pie background: rgb('white') {
//				data 'S' value: first(COVID_Maths).S color: rgb('green') ;				
//				data 'E' value: first(COVID_Maths).E color: rgb('orange') ;
//				data 'I' value: first(COVID_Maths).I color: rgb('red') ;
//				data 'H' value: first(COVID_Maths).H color: rgb('magenta') ;				
//				data 'M' value: first(COVID_Maths).M color: rgb('chocolate') ;
//				data 'D' value: first(COVID_Maths).D color: rgb('black') ;
//				data 'R' value: first(COVID_Maths).R color: rgb('blue');
//			}
//		} 
//Graphic line
		
	display COVID_Com refresh: every(#sec) {
			chart "Covid Model2" type: series background: rgb('white') {
				data 'S' value: first(COVID_Maths).S color: rgb('green') ;				
				data 'E' value: first(COVID_Maths).E color: rgb('orange') ;
				data 'I' value: first(COVID_Maths).I color: rgb('red') ;
				data 'H' value: first(COVID_Maths).H color: rgb('magenta') ;				
				data 'M' value: first(COVID_Maths).M color: rgb('chocolate') ;
			    data 'D' value: first(COVID_Maths).D color: rgb('black') ;
				data 'R' value: first(COVID_Maths).R color: rgb('blue');
			}
		}	
	}


// The end of the program
}
