/**
 * @author zberry
 */

function hilite(element)
{
	element.style.backgroundColor = '#eeeeee';
}

function unhilite(element)
{
	element.style.backgroundColor = "#dddddd";
}

function handleClick(permalink, username)
{
	var voted = $('#cb_i_' + permalink)[0].className == "voted";
	
	if(!voted)
	{
	var url = '/polls/' + permalink + '/votes/' + username;
		jQuery.ajax({
			type: 'put',
			url: url,
			success: handleClickSuccess(permalink)}
			//dataType: type
		);
		
	}

function handleClickSuccess(permalink)
{
	//alert('bugs');
	var item = $("#" + permalink)[0];
	var checkImage = $("#cb_i_" + permalink)[0];
	var checkMsg = $("#cb_m_" + permalink)[0];
	checkMsg.innerHTML = "I'm in!";
	checkImage.className = 'voted';
	
	var voteCount = $("#cb_v_" + permalink)[0];
	voteCount.innerHTML = Number(voteCount.innerHTML) + 1;
	
}

function togglePoll()
{
	var f = $('#add-poll-form')[0];
	f.style.display = (f.style.display == "none" || f.style.display == "" ? "block" : "none");
}

function submitNewPoll()
{
	/*
	$.ajax({
		type: "POST",
		url: "bin/process.php",
		data: 'abc',
		success: function() {
			alert('success');
		}
	});*/
}}