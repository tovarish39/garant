import React from "react";
import Select from "./Select"

export default ({moderators, isActive, onBlurComment, onChangeStatus})=>{


    const moderatorsByStatusRights = moderators.filter(moderator=>{
        if      ( isActive && moderator.rights_status == 'active')   return moderator
        else if (!isActive && moderator.rights_status == 'inactive') return moderator
    })


    function inProcessDispudesSize({disputes}){
        const inProcess = disputes.filter(dispute=>dispute.state == 'in_process')
        return inProcess.length
    }
    function finishedDisputesSize({disputes}){
        const seller_lost   = []
        const custumer_lost = []
        const all_lost      = []
        if (disputes.length > 0) {
            disputes.forEach(dispute => {
                if (dispute.dispute_lost == 'seller_lost') seller_lost.push(dispute)
                if (dispute.dispute_lost == 'custumer_lost') custumer_lost.push(dispute)
                if (dispute.dispute_lost == 'all_lost') all_lost.push(dispute)
            });
        }
        return `${disputes.length} | ${seller_lost.length} | ${custumer_lost.length} | ${all_lost.length}`
    }

    return(
        <div id="Table">
            <div id="TableHead" className="fr6 f-s-07">
                <div className="cell6">telegram_id</div>
                <div className="cell6">username</div>
                <div className="cell6">комментарий</div>
                <div className="cell6">рассмотренных споров <br/>всего | покупатель_выйграл | продавец_выйграл | гарант_выйграл</div>
                <div className="cell6">количество активных споров</div>
                <div className="cell6">статус</div>
            </div>  
            
            {moderatorsByStatusRights.map(moderator => (
                <div className="row fr6 f-s-07" key={moderator.id}>
                    <span className="cell6 cell6-body">{moderator.telegram_id}</span>
                    <span className="cell6 cell6-body">{moderator.username}</span>
                    <span className="cell6 cell6-body">
                        <textarea name="comment" className="f-s-08" placeholder={moderator.comment} data-id={moderator.id} onBlur={onBlurComment}></textarea>
                    </span>
                    <span className="cell6 cell6-body">{finishedDisputesSize(moderator)}</span>
                    <span className="cell6 cell6-body">{inProcessDispudesSize(moderator)}</span>
                    <span className="cell6 cell6-body">
                        { isActive && <Select 
                            onChangeStatus={onChangeStatus} 
                            rightsStatus={'активный'} 
                            moderator={moderator}/>}
                        {!isActive && <Select 
                            onChangeStatus={onChangeStatus} 
                            rightsStatus={'не активный'} 
                            moderator={moderator}/>}
                    </span>
                </div>
            ))}                      
        </div>
)}