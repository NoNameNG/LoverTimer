<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>{modname}</title>
		<link href="./templates/css/style.css" rel="stylesheet"/>
		<link href="./templates/css/font-awesome.min.css" rel="stylesheet"/>
		<script src="./templates/js/jquery-3.1.1.min.js"></script>
	</head>
	
	<script type="text/javascript">
	
		spaceclass = "";
		bodycolor = "";

		$(document).ready(function(){
	
			var thishours = new Date().getHours();

			if(thishours >= 6 && thishours < 12){
				bodycolor = "#FFAF00";
				spaceclass = "sun morning";
			}
			
			if(thishours >= 12 && thishours < 18){
				bodycolor = "#008EFF";
				spaceclass = "sun day";
			}
			
			if (thishours >= 18){
				bodycolor = "#C42D16";
				spaceclass = "sun evening";
			}
			
			if (thishours < 6){
				bodycolor = "#000822";
				spaceclass = "moon";
			}

			$("body").css("background",bodycolor);
				
				
			$("#sidebar-hide-opener").click(function(e){

				Sidebars.Open($("#sidebar-hide"));
				e.preventDefault();
			});
			
			$("#sidebar-hide-closer").click(function(e){
				
				Sidebars.Close($("#sidebar-hide"));
				e.preventDefault();
			});
				
		});
	
		$(window).on("load", function(){
		
			setTimeout(function(){$("#HeadTitle").addClass("anim")},500);
			setTimeout(function(){$("#wrapper").addClass("anim")},1000);
			setTimeout(function(){$("space").addClass(spaceclass);},1500);
			setTimeout(function(){$("#sidebar-hide-opener").addClass("anim");},2000);
		
		});
		
		Sidebars = {
		
			Open: function($panel) {
				
				$panel.addClass("open");
				$('main').addClass('blur');
				$('body').append("<div id='alloverlay' class='alloverlay'></div>");
				$('#alloverlay').on('click.closeside', function() {
					Sidebars.Close($panel);
				});
				$(document).on('keyup.closeside', function(e) {
					e.preventDefault();
					if (e.which == '27') Sidebars.Close($panel);
				});
				return false;
			},
			Close: function($panel) {
				$panel.removeClass('open');
				$('main').removeClass('blur');
				$('#alloverlay').off('click.closeside');
				$('#alloverlay').remove();
				$(document).off('keyup.closeside');
				return false;
			},
			Toggle: function($panel) {
				if ($panel.hasClass('open')) Sidebars.Close($panel);
				else Sidebars.Open($panel);
				return false;
			}
		
		}

	</script>

	<body>
	
		<main>
	
		<h1 id="HeadTitle">{modname}</h1>
	
		<div class="wrapper" id="wrapper">
		{content}
		</div>
		
		</main>
		
		[logged]
		
		<a href="#" id="sidebar-hide-opener"><i class="fa fa-bars"></i></a>
		
		<menu class="sidebar-hide" id="sidebar-hide">
		
			<ul class="title">
			
				<li class="one">Привет, {uname}</li>
				<li class="two"><a href="#" id="sidebar-hide-closer"><i class="fa fa-close"></i></a></li>
			
			</ul>
			
			<ul class="menu">
			
				<li><a href="./"><i class="fa fa-clock-o"></i> Таймер до нашей встречи</a></li>
				<li><a href="./?do=logout"><i class="fa fa-power-off"></i> Выход из аккаунта</a></li>
			
			</ul>
			
			<ul class="info">
			
				<li><i class="fa fa-eye"></i> Взглядов на таймер: {count}</li>
				<li><i class="fa fa-microchip"></i> Таймер до нашей встречи, v.2.0.1, с любовью для тебя <i class="fa fa-heart"></i></li>
			
			</ul>
		
		</menu>
		
		[/logged]
		
		<space></space>
		
	</body>

</html>