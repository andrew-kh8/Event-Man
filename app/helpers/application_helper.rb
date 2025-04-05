module ApplicationHelper
  def login_logout_buttons
    if organization_signed_in?
      button_to 'Выйти', destroy_organization_session_path, method: :delete,
                                                            class: 'px-4 py-2 mt-2 font-semibold bg-transparent
                                                              rounded-lg    md:mt-0 md:ml-4 hover:text-gray-900
                                                              focus:text-gray-900 hover:bg-gray-200 focus:bg-gray-200
                                                              focus:outline-none focus:shadow-outline'
    else
      button_to 'Войти', new_organization_session_path,
                class: 'px-4 py-2 mt-2 font-semibold bg-transparent rounded-lg
                    md:mt-0 md:ml-4 hover:text-gray-900 focus:text-gray-900 hover:bg-gray-200 focus:bg-gray-200
                    focus:outline-none focus:shadow-outline'
    end
  end
end
