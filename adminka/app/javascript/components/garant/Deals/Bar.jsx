import React from "react";
import BarButton from "../Users/BarButton";

export default ({isActive, onActiveClick})=>{
    const tryActive   =  ( isActive)           ? 'selected' : 'not-selected'
    const tryInactive =  (!isActive)           ? 'selected' : 'not-selected'

    return(
        <div id="Bar">
            
            <div id="leftSideBar">
                <div>
                    <BarButton 
                        text='активные' 
                        onClick={onActiveClick} 
                        classs={`b-r-left w-10 ${tryActive}`}
                        />
                    <BarButton 
                        text='архив' 
                        onClick={onActiveClick} 
                        classs={`b-r-right w-10 ${tryInactive}`}/>
                </div>
            </div>

            <div id="rightSideBar">
            </div>
            
        </div>
)}