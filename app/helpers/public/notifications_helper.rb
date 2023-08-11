module Public::NotificationsHelper
    
    def unchecked_notifications
        @notifications = current_user.passive_notifications.where(checked: false)
    end
    
    def notification_form(notification)
        @visitor = notification.visitor
        @comment = nil
        your_recipe = link_to 'あなたの投稿', recipe_path(notification.recipe_id), style: "font-weight: bold;"
        @visitor_comment = notification.comment_id
        case notification.action
            when "favorite" then
                tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "が" + 
                tag.a('あなたの投稿', href: recipe_path(notification.recipe_id), style: "font-weight: bold;") + "にいいいねしました"
            when "comment" then
                tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "が" +
                tag.a('あなたの投稿', href: recipe_path(notification.recipe_id), style: "font-weight: bold;") + "にコメントしました"
        end
    end
end
