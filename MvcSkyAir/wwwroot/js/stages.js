// script.js 
document.addEventListener("DOMContentLoaded", function () { 
	const progressListItems = 
		document.querySelectorAll("#progressbar li"); 
	const progressBar = 
		document.querySelector(".progress-bar"); 
	let currentStep = 0; 

	function updateProgress() { 
		const percent = 
			(currentStep / (progressListItems.length - 1)) * 100; 
		progressBar.style.width = percent + "%"; 

		progressListItems.forEach((item, index) => { 
			if (index === currentStep) { 
				item.classList.add("active"); 
			} else { 
				item.classList.remove("active"); 
			} 
		}); 
	} 

	function showStep(stepIndex) { 
		const steps = 
			document.querySelectorAll(".step-container fieldset"); 
		steps.forEach((step, index) => { 
			if (index === stepIndex) { 
				step.style.display = "block"; 
			} else { 
				step.style.display = "none"; 
			} 
		}); 
	} 

	function nextStep() { 
		if (currentStep < progressListItems.length - 1) { 
			currentStep++; 
			showStep(currentStep); 
			updateProgress(); 
		} 
	} 

	function prevStep() { 
		if (currentStep > 0) { 
			currentStep--; 
			showStep(currentStep); 
			updateProgress(); 
		} 
	} 

	const nextStepButtons = 
		document.querySelectorAll(".next-step"); 
	const prevStepButtons = 
		document.querySelectorAll(".previous-step"); 

	nextStepButtons.forEach((button) => { 
		button.addEventListener("click", nextStep); 
	}); 

	prevStepButtons.forEach((button) => { 
		button.addEventListener("click", prevStep); 
	}); 
});
