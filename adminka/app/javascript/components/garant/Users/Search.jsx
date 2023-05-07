import React, {useState, useEffect} from "react";



export default ({onChangeSearching}) => {
return (
<input id="search-user" className="w-10" type="text" placeholder="Поиск..." onChange={onChangeSearching} />

)

}

