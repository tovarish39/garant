import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

import GarantUsers      from "../components/garant/Users/GarantUsers";
import GarantDeals      from "../components/garant/Deals/GarantDeals";
import GarantModerators from "../components/garant/Moderators/GarantModerators";
import GarantFinances   from "../components/garant/Finances/GarantFinances";

import BlackListUsers      from "../components/black_list/Users/BlackListUsers";


export default (
  <Router>
    <Routes>
    
      <Route path="/garant/users"      element={<GarantUsers />} />
      <Route path="/garant/moderators" element={<GarantModerators />} />
      <Route path="/garant/deals"      element={<GarantDeals />} />
      <Route path="/garant/finances"   element={<GarantFinances />} />
      
      <Route path="/black_list/users"   element={<BlackListUsers />} />
    
    </Routes>
  </Router>
);