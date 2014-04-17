	  $.ajax({
			url: "twitter_rss.xml"
		}).done(function ( data ) {
			var $xml = $(data);
			$xml.find("item").each(function() {
				var $this = $(this),
				item = {
					title: $this.find("title").text(),
					pubDate: $this.find("pubDate").text(),
				}				
				$('#twitter_info').append("<div class=\"tweet_hidden\"><div>" + item.title.substring(16) + "</div><div class=\"tweet_date\">" + new Date(item.pubDate).toLocaleString() + "<button class=\"nwice_button\">>></button></div>");
			});

			$('#twitter_info').children(":first").attr('class', "tweet_active");
			
			$('#twitter_info').on('click', function() {
				$('#twitter_info').find(".tweet_active").attr('class', "tweet_hidden").next().attr('class', "tweet_active");				 
			});							
	  });

