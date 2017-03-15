ThinkingSphinx::Index.define :user, :with => :active_record do
  indexes name
  indexes email
end
