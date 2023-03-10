# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    h2 "Таблиця скарг", style: "text-align: center;"
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        pie_chart Complaint.all.group_by { |complaint| t("state.#{complaint.state}") }.map { |el| [el[0], el[1].count] }
      end
    end
    h2 "Таблиця запитів на зміну тарифу", style: "text-align: center; margin-top: 15px;"
    div class: "blank_slate_container", id: "dashboard_default_message_1" do
      span class: "blank_slate" do
        pie_chart ChangeTariffRequest.all.group_by { |change_tariff_request| t("state.#{change_tariff_request.state}") }.map { |el| [el[0], el[1].count] }
      end
    end
    h2 "Карта споживачів", style: "text-align: center; margin-top: 15px;"
    div class: "map", id: "consumers_map", style: "width: max; height: 1000px;"

    script src: "https://maps.googleapis.com/maps/api/js?key=AIzaSyBXDQwrbDQ-1XjW9DiYxadgiO7-iAkL6yw&libraries=&v=weekly&language=uk"

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
