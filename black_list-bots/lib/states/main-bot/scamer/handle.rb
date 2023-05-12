def view_complaints_to_scamer
    accepted_complaints = Complaint.where(telegram_id:$user.telegram_id).filter {|complaint| complaint.status == 'accepted_complaint'}
    telegraph_links = accepted_complaints.map(&:telegraph_link) 
    Send.mes(Text.view_complaints(telegraph_links), M::Inline.view_complaints)
end

def to_justification
    Send.mes(Text.explain_justification)
end

def justification_already_used
    Send.mes(Text.justification_already_used)
end