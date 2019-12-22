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

prepareNextCard = function() {
	$("#answer-button").css("display", "block");
	$("#again-button").css("display", "none");
	$("#good-button").css("display", "none");
	$("#card-answer").css("display", "none");
}

masteredClicked = function() {
	prepareNextCard();
}

deleteClicked = function() {
	prepareNextCard();
}

displayAnswer = function() {
	$("#answer-button").css("display", "none");
	$("#again-button").css("display", "block");
	$("#good-button").css("display", "block");
	$("#card-answer").css("display", "block");
}

againClicked = function() {
	prepareNextCard();
}

goodClicked = function() {
	prepareNextCard();
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

	    		var data = { 
	    			key: "AIzaSyAZRIGDoQtbpumlDHk4M4IWvu9TobmtXSM", 
	    			q: text, 
	    			target: "en", 
	    		}

	        	// Ask for the translation using the API key from the Google account
	        	$.getJSON("https://translation.googleapis.com/language/translate/v2", data)
	        	.done(function(data) {
	        		console.log(data.data.translations[0].translatedText);
	        		$("#translation").text(data.data.translations[0].translatedText);
	        	})
	        	.fail(function(data) {
	        		alert( "error" );
	        		console.log(data);
	        	});
	        }
	    }
	}


	createCard = function() {
		if (window.getSelection) {
	    	//alert("selection");
	    	text = window.getSelection().toString();

	    	if(text != "") {

	    		var data = { 
	    			stage: "1", 
	    			source: text,
	    			timesreviewed: "0", 
	    			timessuccess: "0", 
	    			timesfailed: "0", 
	    		}

	    		$.post("/createcard", data)
	        	.done(function(data) {
	        		console.log("Success");
	        	})
	        	.fail(function(data) {
	        		console.log("Error");
	        	});
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
