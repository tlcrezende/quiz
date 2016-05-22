// ==UserScript==
// @name         Hackathon Quiz script
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @include      http*://*.youtube.com/*
// @include      http*://youtube.com/*
// @match        http://tampermonkey.net/scripts.php
// @grant        none
// ==/UserScript==

(function() {
    function httpPost(url, callback)
    {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.onreadystatechange = function() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
                callback(xmlHttp.responseText);
        };
        xmlHttp.open( "POST", url, true);
        xmlHttp.send( null );
    }

    function imprimir_resposta(response) {
        alert("OIEEE");
    }

    function change_score(test_set_id, score) {
        url = "https://192.168.65.182:3000/test_set/"+ test_set_id + "/score/" + score;
        httpPost(url, imprimir_resposta);
    }


    function httpGet(url, callback)
    {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.onreadystatechange = function() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
                callback(xmlHttp.responseText);
        };
        xmlHttp.open( "GET", url, true);
        xmlHttp.send( null );
    }

    function getParameterByName(name) {
        url = window.location.href;
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    function imprimir_resposta(response) {
        alert(response);
    }

    function get_test_set_json() {
        video_id = getParameterByName("v");
        url = "https://192.168.65.182:3000/test_set/api/" + video_id;
        httpGet(url, get_response);
    }

    function get_response(json_string) {
        alert(json_string);
        window.json = JSON.parse(json_string);
        var tests = window.json[0]["tests"];
        var size  = tests.length;

        var questions = [];
        var times = [];
        var alts1 = [];
        var alts2 = [];
        var alts3 = [];
        var alts4 = [];
        var answers = [];
        var alternatives = [];
        var quiz_htmls = [];
        var parou = [];

        window.tudo = [];

        for(i=0; i<size; i++) {
            var quiz={};

            questions.push(tests[i]["question"]);

            d = new Date(tests[i]["time"]);
            times.push(d.getUTCSeconds() + 60*d.getUTCMinutes() + 3600*d.getUTCHours());

            alts1.push(tests[i]["alternative1"]);
            alts2.push(tests[i]["alternative2"]);
            alts3.push(tests[i]["alternative3"]);
            alts4.push(tests[i]["alternative4"]);
            alternatives.push([alts1[i], alts2[i], alts3[i], alts4[i]]);
            answers.push('q' + (i+1) + tests[i]["answer"]);
            quiz_htmls.push(createQuizHtml(questions[i], alternatives[i][0], alternatives[i][1], alternatives[i][2], alternatives[i][3], i+1));
            parou.push(false);

            quiz["question"] = questions[i];
            quiz["time"] = times[i];
            quiz["alternatives"] = alternatives[i];
            quiz["answer"] = answers[i];
            quiz["quiz_html"] = quiz_htmls[i];
            quiz["parou"] = parou[i];

            window.tudo.push(quiz);
        }
        return window.tudo;
    }

    get_test_set_json();

    function createQuizHtml(pergunta, ansA, ansB, ansC, ansD, number) {
        var aux='q'+number;
        var string1='<p class="question">';

        return '<p class="question">' + number + '. ' + pergunta + '</br></p><ul class="answers"><input type="radio" name="'+aux+'" value="a" id="'+aux+'1"><label for="'+aux+'a">' + ansA + '</label><br/><input type="radio" name="'+aux+'" value="b" id="'+aux+'2"><label for="'+aux+'b">' + ansB + '</label><br/><input type="radio" name="'+aux+'" value="c" id="'+aux+'3"><label for="'+aux+'c">' +ansC + '</label><br/><input type="radio" name="'+aux+'" value="d" id="'+aux+'4"><label for="'+aux+'d">' + ansD + '</label><br/></ul><input type="submit" value="Submit" id="submit"><input type="submit" value="Skip" id="skip">';
    }

    var video = document.querySelectorAll("video")[0];
    var iframe = document.createElement('iframe');
    div = document.getElementsByClassName('player-api player-width player-height')[0];
    div.appendChild(iframe);

    div = document.getElementsByClassName('like-button-renderer actionable')[0];

    var like = document.createElement('like');
    div.appendChild(like);
    like.style.backgroundColor = '#1b9e1f';
    like.style.width = '100px';
    like.style.height = '100px';
    like.style.position = 'absolute';
    like.style.top = '50px';
    like.style.left = '550px';
    like.onclick = buttonLike;
    like.style.zIndex = 1000;

    var dislike = document.createElement('dislike');
    div.appendChild(dislike);
    dislike.style.backgroundColor = '#c30808';
    dislike.style.width = '100px';
    dislike.style.height = '100px';
    dislike.style.position = 'absolute';
    dislike.style.top = '50px';
    dislike.style.left = '740px';
    dislike.onclick = buttonDislike;
    dislike.style.zIndex = 1000;

    iframe.style.backgroundColor = "white";
    iframe.style.position = "absolute";
    iframe.style.zIndex = 100;
    iframe.style.top = 0;
    iframe.style.left = 0;

    iframe.style.width = video.style.width;
    iframe.style.height = video.style.height;
    iframe.style.visibility = "hidden";

    var currentQuiz = 0;

    function playVideo() {
        video.play();
    }

    function pauseVideo() {
        video.pause();
    }

    function changeQuiz(html, answer) {
        iframe.contentWindow.document.open();
        iframe.contentWindow.document.write(html);
        iframe.contentWindow.document.close();
        iframe.contentWindow.document.getElementById("submit").onclick = checkAnswer;
        iframe.contentWindow.document.getElementById("skip").onclick = continuePlayback;
    }

    function pauseVideoAt(){
        if (video.currentTime >= window.tudo[currentQuiz]["time"] && video.currentTime <= window.tudo[currentQuiz]["time"] + 2 && !window.tudo[currentQuiz]["parou"]) {

            changeQuiz(window.tudo[currentQuiz]["quiz_html"], window.tudo[currentQuiz]["answer"]);

            pauseVideo();
            window.tudo[currentQuiz]["parou"]=true;
            iframe.style.visibility="visible";
        }
    }

    function buttonLike(){
        playVideo();
        change_score(window.json[0]["id"], 10);
    }

    function buttonDislike(){
        pauseVideo();
        change_score(window.json[0]["id"], -10);
    }

    function checkAnswer(){
        if(iframe.contentWindow.document.getElementById(window.tudo[currentQuiz]["answer"]).checked){
            continuePlayback();
        }
        else{
            wrongAnswer();
        }
    }

    function wrongAnswer() {
        alert('wrong answer');
    }

    function continuePlayback(){
        iframe.style.visibility="hidden";
        playVideo();
        if (currentQuiz < window.tudo.length-1){
            currentQuiz += 1;
        }
    }

    video.ontimeupdate = function(){
        pauseVideoAt();
    };

})();
