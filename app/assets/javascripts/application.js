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

refreshArrows = function() {
	if(parseInt($("#page-number").text()) == 1) {
		$("#lesson-go-back").css("display", "none");
	} else {
		$("#lesson-go-back").css("display", "block");
	}
}

goToPage = function(page_to_display) {
	var lesson_text = $("#full-lesson").text();

	var words_array = lesson_text.split(" ");

	// Break up the lesson in pages of 370 characters max 
	var max_character_page = 50;
	var number_of_pages = Math.ceil(words_array.length / max_character_page);

	var starting_character = (page_to_display - 1) * max_character_page
	var page_words = words_array.slice(starting_character, starting_character + max_character_page);

	// create a separate span for each word 
	var page_text = "";
	var characters_per_line = 48;

	// keep track of the number of characters for the current line
	var current_characters = 0;  
	for(var i = 0; i < page_words.length; i++) {
		page_text += '<span class="lesson-word">' + page_words[i] + '</span>';
		current_characters += page_words[i].length;

		if(i < page_words.length - 1) {
			var next_word_length = page_words[i+1].length

			if(current_characters + next_word_length >= characters_per_line) {
				page_text += "<br>"

				// reset (we start counting for the next line)
				current_characters = 0;
			} 
		}
	}

	$(".article-section").prepend(page_text);
}


previousPage = function() {
	$(".article-section").empty();
	var page_number = parseInt($("#page-number").text());
	var page_to_display = page_number - 1;
	page_to_display = page_to_display;
	goToPage(page_to_display);

	// update page number
	$("#page-number").text(page_to_display);
	refreshArrows();
}

nextPage = function() {
	$(".article-section").empty();
	var page_number = parseInt($("#page-number").text());
	var page_to_display = page_number + 1;
	page_to_display = page_to_display;
	goToPage(page_to_display);

	// update page number
	$("#page-number").text(page_to_display);
	refreshArrows();
}

format_lesson = function() {
	var lesson_text = $(".article-section").text();

	var words_array = lesson_text.split(" ");

	// Break up the lesson in pages of 370 characters max 
	var number_of_pages = Math.ceil(words_array.length / 370);

	var all_pages = [];
	for(var i = 0; i < number_of_pages; i++) {
		var single_page = words_array.slice(i * 370, i + 370);
		all_pages.push(single_page);
	}

}

hover_word = function () {
	//$(".lesson-word").onClick(
	//	function(){
	//		$(this).addClass("word-clicked");		
	//	}
	//)

}

pronounce = function (){
	languagesInfo = {
		"spanish" : "es-MX",
		"french" : "fr-FR",
		"japanese" : "ja-JP",
		"chinese" : "zh-TW",
		"korean" : "ko-KR",
		"german" : "de-DE",
		"italian" : "it-IT",
		"russian" : "ru-RU",
		"portuguese" : "pt-BR",
		"hindi" : "hi-IN",
		"dutch" : "nl-NL",
		"turkish" : "tr-TR",
		"polish" : "pl-PL"
	}

	var msg = new SpeechSynthesisUtterance();
	msg.volume = 1;
	msg.rate = 1;
	msg.pitch = 1;
	msg.text = $("#word-selected").text();

	var artLang = $("#article-language").text().toLowerCase();

	msg.lang = languagesInfo[artLang];
	console.log(languagesInfo[artLang]);
	speechSynthesis.speak(msg);
}

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
	$("#word-recall").text(nextCardData.translation);
	$("#card-answer").text(nextCardData.source);
	$("#memory-stage").text(get_memory_stage(nextCardData.stage));
	$("#times-reviewed").text(nextCardData.timesreviewed);
	$("#successful-recalls").text(nextCardData.timessuccess);
	$("#failed-recalls").text(nextCardData.timesfailed);	

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
		format_lesson();
		change_body_color();
		createCardsAndDisplayInfo();
		adapt_navbar_color();
		hover_word();
		goToPage(1);
		refreshArrows();
	})
