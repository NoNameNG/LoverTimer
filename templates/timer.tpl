<script type="text/javascript">

$(document).ready(function(){

	$(window).resize(function(){

		$("#tabs .tabpages li.active").click();
	
	});

	var starttime = '5 Aug 2022 20:30:00 GMT+07:00';
	var endtime = '2 Sep 2022 17:00:00 GMT+07:00';
	
	var durationtime = (Date.parse(endtime) - Date.parse(starttime))/1000;
	
	$("#timerdo .fulldate > span").text(endtime);
	$("#timerot .fulldate > span").text(starttime);
	
	tickTime(endtime,starttime,durationtime);
	
	var timeitick = setInterval(function(){tickTime(endtime,starttime,durationtime)},1000);

	$("#tabs .tabpages").on("click", "li", function(e){

		var newtab = $("#tabs .tablist > li")[$(this).index()];
		
		$("#tabs .tabpages li").removeClass("active");
		$(this).addClass("active");

		var left = -$(newtab).position().left;
		
		$("#tabs .tablist").css({

			"transform":"translateX("+left+"px)",
			"-webkit-transform":"translateX("+left+"px)",
			"-moz-transform":"translateX("+left+"px)"

		  });
		
		$("#tabs .tablist > li").removeClass("active");
		$(newtab).addClass("active");

		e.preventDefault();
	
	});
		
});

function tickTime(endtime,starttime,durationtime){

	//Осталось до

	var t = (Date.parse(endtime) - Date.parse(new Date()))/1000;
	
	var seconds,minutes,hours,days,weeks,months,$output,percent;
	
	if(t>=0){
		
		seconds = Math.floor( t % 60 );
		minutes = Math.floor( (t/60) % 60 );
		hours = Math.floor( (t/(60*60)) % 24 );
		days = Math.floor( t/(60*60*24) );
		weeks = ( t/(60*60*24) / 7 ).toFixed(1);
		months = ( t/(60*60*24) / 30 ).toFixed(1);
		
		$output = $('#timerdo');

		$('.hours',$output).text(('0' + hours).slice(-2));
		$('.minutes',$output).text(('0' + minutes).slice(-2));
		$('.seconds',$output).text(('0' + seconds).slice(-2));

		$('months',$output).text(months);
		$('weeks',$output).text(weeks);
		$('days',$output).text(days);
		$('total',$output).text(t);
		
		percent = 100-(Math.floor(t*100/durationtime));

	}else{
		
		percent = 100;
	
	}
	
	$('percent',$output).text(100-percent);
	$("#progressbar > p").css("width",percent+"%");

	//Прошло от
	
	$output = $('#timerot');

	t = (Date.parse(new Date()) - Date.parse(starttime))/1000;

	seconds = Math.floor( t % 60 );
	minutes = Math.floor( (t/60) % 60 );
	hours = Math.floor( (t/(60*60)) % 24 );
	days = Math.floor( t/(60*60*24) );
	weeks = ( t/(60*60*24) / 7 ).toFixed(1);
	months = ( t/(60*60*24) / 30 ).toFixed(1);

	$('.hours',$output).text(('0' + hours).slice(-2));
	$('.minutes',$output).text(('0' + minutes).slice(-2));
	$('.seconds',$output).text(('0' + seconds).slice(-2));

	$('months',$output).text(months);
	$('weeks',$output).text(weeks);
	$('days',$output).text(days);
	$('total',$output).text(t);
	$('percent',$output).text(percent);
	
	//Время в регионах
	t = new Date();
	utc = new Date(t.getTime() + t.getTimezoneOffset() * 60 * 1000);

	$output = $("#KRSK");
	
	shift = new Date(utc.getTime() + 60*60*7*1000);

	$('.hours',$output).text(('0' + shift.getHours()).slice(-2));
	$('.minutes',$output).text(('0' + shift.getMinutes()).slice(-2));
	$('.seconds',$output).text(('0' + shift.getSeconds()).slice(-2));
	
	$('.fulldate',$output).text(('0'+shift.getDate()).slice(-2) + "." + ('0'+(shift.getMonth()+1)).slice(-2) + "." + shift.getFullYear() );

	$output = $("#RDGRSK");
	
	shift = new Date(utc.getTime() + 60*60*8*1000);

	$('.hours',$output).text(('0' + shift.getHours()).slice(-2));
	$('.minutes',$output).text(('0' + shift.getMinutes()).slice(-2));
	$('.seconds',$output).text(('0' + shift.getSeconds()).slice(-2));
	
	$('.fulldate',$output).text(('0'+shift.getDate()).slice(-2) + "." + ('0'+(shift.getMonth()+1)).slice(-2) + "." + shift.getFullYear() );

}

</script>

<div id="tabs">

	<ul class="tabpages">
	
		<li class="active"><a href="#">Осталось</a></li>
		<li><a href="#">Прошло</a></li>
	
	</ul>
	
	<ul class="tablist">
	
		<li class="active" id="timerdo">
		
			<div class="tabcontent">
			
				<div class="fulldate">До: <span>-</span></div>
			
				<ul class="threecols clock">
				
					<li class="hours">00</li>
					<li class="minutes">00</li>
					<li class="seconds">00</li>
				
				</ul>
				
				<ul class="threecols date">
				
					<li>Дней: <days>0</days></li>
					<li>Недель: <weeks>0</weeks></li>
					<li>Месяцев: <months>0</months></li>
				
				</ul>
				
				<ul class="cols date">

					<li>Секунд: <total>0</total></li>
					<li>Процентов: <percent>0</percent>%</li>

				</ul>
				
			</div>
		
		</li>
		<li id="timerot">
		
			<div class="tabcontent">
			
				<div class="fulldate">От: <span>-</span></div>
			
				<ul class="threecols clock">
				
					<li class="hours">00</li>
					<li class="minutes">00</li>
					<li class="seconds">00</li>
				
				</ul>
				
				<ul class="threecols date">
				
					<li>Дней: <days>0</days></li>
					<li>Недель: <weeks>0</weeks></li>
					<li>Месяцев: <months>0</months></li>
				
				</ul>
				
				<ul class="cols date">

					<li>Секунд: <total>0</total></li>
					<li>Процентов: <percent>0</percent>%</li>

				</ul>
				
			</div>
		
		</li>
	
	</ul>

</div>
<div id="progressbar"><p></p></div>
<ul class="cols miniclockblock">

	<li id="KRSK">
	
		В Красноярске
		<ul class="threecols miniclock">
		
			<li class="hours">00</li>
			<li class="minutes">00</li>
			<li class="seconds">00</li>
		
		</ul>
		
		<div class="fulldate">-</div>
		
	
	</li>
	<li id="RDGRSK">
	
		В Рудногорске
		<ul class="threecols  miniclock">
		
			<li class="hours">00</li>
			<li class="minutes">00</li>
			<li class="seconds">00</li>
		
		</ul>
		
		<div class="fulldate">-</div>
		
	</li>

</ul>