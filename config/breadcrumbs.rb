crumb :root do
  link 'ホーム', root_path
end

crumb :user_show do
  link "マイページ", user_path(current_user)
  parent :root
end

crumb :listings_user do
  link "出品した商品 - 出品中",listings_user_path(current_user)
  parent :user_show
end

crumb :in_progress_user do
  link "出品した商品 - 取引中",in_progress_user_path(current_user)
  parent :user_show
end

crumb :completed_user do
  link "出品した商品 - 売却済み",completed_user_path(current_user)
  parent :user_show
end

crumb :purchase_user do
  link "購入した商品 - 取引中",purchase_user_path(current_user)
  parent :user_show
end

crumb :purchased_user do
  link "購入した商品 - 過去の取引",purchased_user_path(current_user)
  parent :user_show
end




# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).