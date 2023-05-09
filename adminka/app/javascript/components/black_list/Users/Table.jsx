import React from "react";
// import Select from "./Select"

export default ({
    blackListUsers
})=>{


    // const moderatorsByStatusRights = moderators.filter(moderator=>{
    //     if      ( isActive && moderator.rights_status == 'active')   return moderator
    //     else if (!isActive && moderator.rights_status == 'inactive') return moderator
    // })


    // function inProcessDispudesSize({disputes}){
    //     const inProcess = disputes.filter(dispute=>dispute.state == 'in_process')
    //     return inProcess.length
    // }
    // function finishedDisputesSize({disputes}){
    //     const seller_lost   = []
    //     const custumer_lost = []
    //     const all_lost      = []
    //     if (disputes.length > 0) {
    //         disputes.forEach(dispute => {
    //             if (dispute.dispute_lost == 'seller_lost') seller_lost.push(dispute)
    //             if (dispute.dispute_lost == 'custumer_lost') custumer_lost.push(dispute)
    //             if (dispute.dispute_lost == 'all_lost') all_lost.push(dispute)
    //         });
    //     }
    //     return `${disputes.length} | ${seller_lost.length} | ${custumer_lost.length} | ${all_lost.length}`
    // }

    return(
        <div id="Table">
            <div id="TableHead" className="fr6 f-s-07">
                <div className="cell6">telegram_id</div>
                <div className="cell6">username</div>
                <div className="cell6">Дата регистрации</div>
                <div className="cell6">Жалоб подано</div>
                <div className="cell6">Жалоб принято</div>
                <div className="cell6">Статус</div>
            </div>  
            
            {blackListUsers.map(user => (
                <div className="row fr6 f-s-07" key={user.id}>
                    <span className="cell6 cell6-body">{user.telegram_id}</span>
                    <span className="cell6 cell6-body">{user.username}</span>
                    <span className="cell6 cell6-body">{user.created_at}</span>
                    <span className="cell6 cell6-body">{user.create_scamers_size}</span>
                    <span className="cell6 cell6-body">{user.self_scamers_size}</span>
                    <span className="cell6 cell6-body">{user.is_self_scamer}</span>
                </div>
            ))}                      
        </div>
)}