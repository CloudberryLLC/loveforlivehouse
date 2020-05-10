module LivehousesHelper

  def show_reviewer_photo(reviewer_id)
    begin
      reviewer = User.find(reviewer_id)
      reviewer.basic.profile_photo.attached? ? reviewer.basic.profile_photo : 'nophoto.png'
    rescue
      return 'nophoto.png'
    end
  end

  def show_reviewer_name(reviewer_id)
    reviewer = User.find(reviewer_id)
    reviewer_name = reviewer.basic.firstname + " " + reviewer.basic.lastname
    return reviewer_name
  end

  def qrcode_tag(text, options = {})
    ::RQRCode::QRCode.new(text).as_svg(options).html_safe
  end

end
