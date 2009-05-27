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
	    success: handleClickSuccess(permalink)});
	
    }
}

function handleClickSuccess(permalink)
{
    var checkImage = $("#cb_i_" + permalink)[0];
    var checkMsg = $("#cb_m_" + permalink)[0];
    checkMsg.innerHTML = "I'm in!";
    checkImage.className = 'voted';
    
    var voteCount = $("#cb_v_" + permalink)[0];
    voteCount.innerHTML = Number(voteCount.innerHTML) + 1;    
}