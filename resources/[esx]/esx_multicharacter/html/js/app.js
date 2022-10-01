var money = Intl.NumberFormat('en-US', {
	style: 'currency',
	currency: 'USD',
	minimumFractionDigits: 0
});

(() => {
    Kashacter = {};

    Kashacter.ShowUI = function(data) {
        $('body').css({"display":"block"});
        $('.main-container').css({"display":"block"});
		$('[data-charid=1]').html('<div class="character-info"><p class="character-info-name"><h1>' + `${translate.name} ` + '<span>' + data.firstname +' '+ data.lastname +'</span></h1></p><p class="character-info-work"><h1>' + `${translate.job} ` + '<span>' + data.job +' '+ data.job_grade +'</span></h1></p><p class="character-info-money">' + `${translate.money} ` + '<span> '+ money.format(data.money) +'</span></p><p class="character-info-bank">' + `${translate.bank} ` + '<span> '+ money.format(data.bank) +'</span></p><p class="character-info-dateofbirth"><b>' + `${translate.dob} ` + '</b><span>'+ data.dateofbirth +'</span></p><p class="character-info-gender"><b>' + `${translate.gender} ` + '</b><span>'+ data.sex +'</span></p></div>').attr("data-ischar", "true");
		
		
		
    };

    Kashacter.CloseUI = function() {
        $('body').css({"display":"none"});
        $('.main-container').css({"display":"none"});
		$('[data-charid=1]').html('<h3 class="character-fullname"></h3><div class="character-info"><p class="character-info-new"></p></div>');
    };

    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case 'openui':
                    Kashacter.ShowUI(event.data.character);
                    break;
				case 'closeui':
					Kashacter.CloseUI();
					break;
            }
        })
    }

})();
