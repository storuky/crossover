ThinkingSphinx::Index.define :request, :with => :active_record do
  indexes title
  indexes status
  indexes messages.content, as: :messages_content
end
