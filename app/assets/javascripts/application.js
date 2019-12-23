// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

rescheduleCard = function(path) {
// Create a card
var dataCard = { 
	source: $("#card-answer").text()
}

	// reschedule the current card 
	$.post(path, dataCard)
	.done(function(nextCardData) {
		prepareNextCard(nextCardData);
	})
	.fail(function(data) {

	});
}

get_memory_stage = function(stage) {
	if(stage <= 7) {
		return "Short-term memory 🏋️‍♀️";
	} else if (stage > 7 && stage <= 9) {
		return "Long-term memory 🧠";
	} else if (stage == 10) {
		return "Mastered 🎓";
	} else {
		return "Unknow stage 🤔";
	}
}

prepareNextCard = function(nextCardData) {

	$("#answer-button").css("display", "block");
	$("#again-button").css("display", "none");
	$("#good-button").css("display", "none");
	$("#card-answer").css("display", "none");

	// Display next card's fields
	console.log(nextCardData);
	$("#word-recall").text(nextCardData.translation);
	$("#card-answer").text(nextCardData.source);
	$("#memory-stage").text(get_memory_stage(nextCardData.stage));

}



displayAnswer = function() {
	$("#answer-button").css("display", "none");
	$("#again-button").css("display", "block");
	$("#good-button").css("display", "block");
	$("#card-answer").css("display", "block");
}

againClicked = function() {
	rescheduleCard("/reschedule_again");
}

goodClicked = function() {
	rescheduleCard("/reschedule_good");
}

masteredClicked = function() {
	rescheduleCard("/mastered");
}

deleteClicked = function() {
	rescheduleCard("/delete_card");
}

adapt_navbar_color = function() {
	if (top.location.pathname != "/") {
		$("#miner-navbar").css("background-color","rgba(255, 255, 255, 1)");
		$(".miner-menu-item").addClass("black-item");
	}
}

displayInfoSidebar = function() {
	var text = "";
	if (window.getSelection) {
	    	//alert("selection");
	    	text = window.getSelection().toString();

	    	if(text != "") {


	    		$(".word-highlighted").text(text);

	    		// Data to be sent to google translate
	    		var data = { 
	    			key: "AIzaSyAZRIGDoQtbpumlDHk4M4IWvu9TobmtXSM", 
	    			q: text, 
	    			target: "en", 
	    		}

	        	// Ask for the translation using the API key from the Google account
	        	translatedText = "";
	        	$.getJSON("https://translation.googleapis.com/language/translate/v2", data)
	        	.done(function(data) {
	        		translatedText = data.data.translations[0].translatedText
	        		$("#translation").text(translatedText);

	        		// Create a card
	        		var dataCard = { 
	        			stage: 1, 
	        			source: text,
	        			translation: translatedText,
	        			timesreviewed: "0", 
	        			timessuccess: "0", 
	        			timesfailed: "0", 
	        		}

	        		$.post("/createcard", dataCard)
	        		.done(function(data) {
	        			console.log("Card successfully created");
	        		})
	        		.fail(function(data) {
	        			console.log("Error creating the card");
	        		});
	        	})
	        	.fail(function(data) {
	        		alert( "error" );
	        	});

	        	
	        }
	    }
	}


	createCard = function() {
		if (window.getSelection) {
	    	//alert("selection");
	    	text = window.getSelection().toString();

	    	if(text != "") {

	    		
	    	}

	    }
	}

	createCardsAndDisplayInfo = function() {
		if (top.location.pathname.includes('/articles/')) {
			displayInfoSidebar();
			createCard();
		}
	}


	change_body_color = function() {
		if (top.location.pathname.includes('/articles/')) {
			$("body").css("background-color","#FBFBFB");
		} else {
			$("body").css("background-color","#FBFBFB");
		}
	}

	$(document).on('turbolinks:load', function(){
		change_body_color();
		createCardsAndDisplayInfo();
		adapt_navbar_color();
	})
