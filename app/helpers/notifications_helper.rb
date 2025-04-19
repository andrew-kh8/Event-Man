module NotificationsHelper
  def author_name(notification)
    author = notification.author
    return 'Не удалось установить автора' if author.nil?

    if notification.author.is_a?(Person)
      link_to author.full_name, person_path(author)
    else
      link_to author.name, organization_path(author)
    end
  end
end
