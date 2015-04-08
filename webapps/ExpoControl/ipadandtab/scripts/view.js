/*SmartDoc Copyright F-labs's (c) Burlay Eugene */
function message(text,elID){
	 var myDiv = document.createElement("DIV");
	   divhtml ="<div id='dialog-message' title='Предупреждение'  >";
	   divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	   			"<font style='font-size:13px; '>"+ text +"</font>"+"</span>";
	   divhtml += "</div>";
	   myDiv.innerHTML = divhtml;
	   document.body.appendChild(myDiv);
	   $("#dialog").dialog("destroy");
	   $( "#dialog-message" ).dialog({
		height:140,
		modal: true,
		buttons: {
			"Ок": function() {
				$( this ).dialog( "close" );
				$( this ).remove();
				if (elID !=null){
					$("#"+elID).focus()
				}
			}
		}
	});
}