module ApplicationHelper
  
  def edit_and_destroy_buttons(item)
    if current_user
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-primary")
      del = ""
 
      if admin or current_user == item
        del = link_to('Destroy', item, method: :delete, data: {confirm: 'Are you sure?' }, class:"btn btn-danger")
      end

      raw("#{edit} #{del}")
    end
  end

  def round(param)
    number_with_precision(param, precision: 1, significant: false)
  end

  def current_user_membership_of(club)
    membership_of(current_user, club)
  end

  def membership_of(user, club)
    ship = nil
    if user and user.beer_clubs.include?(club)
      ship = Membership.find_by(user_id: user.id, beer_club_id: club.id)
    end
    ship
  end
end
