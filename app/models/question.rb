class Question < ActiveRecord::Base
  #has_any helps us set up the association between question model and the answer model. In this case 'has_many' assumes that the answers table contains a field named 'question_id' that is an integer (this is a rail convention). the depedent option takes values like 'destry' and 'nullify'. 'destroy' will make rails automatically delete associated answers before deleting the question. nullify will make rails turn question_id values of associated records to "NULL" before deleting the question.
  has_many :answers, dependent: :destroy
    belongs_to :category
    belongs_to :user

    validates(:title, {presence: {message: "must be present!"}, uniqueness: true})

  # by having the option: uniqueness: {scope: :title} it ensures that the body
  # must be unique in combination with the title.
  validates :body, presence:   true,
                   length:     {minimum: 7},
                   uniqueness: {scope: :title}

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :email, format: VALID_EMAIL_REGEX

  validate :no_monkey
  validate :no_title_in_body

  after_initialize  :set_defaults
  before_validation :cap_title, :squeeze_title_and_body

  # scope :recent, lambda {|count| where("created_at > ?", 3.day.ago).limit(count) }
  def self.recent(count)
    where("created_at > ?", 3.day.ago).limit(count)
  end

  # scope :search, lambda {|word| where("title ILIKE ? OR body ILIKE ?", "%#{word}%", "%#{word}%")}
  def self.search(word)
    where("title ILIKE :word OR body ILIKE :word", {word: "%#{word}%"})
  end

  def new_first_answers
    answers.order(created_at: :desc)
  end

  private

  def cap_title
    self.title = title.capitalize
  end

  def squeeze_title_and_body
    self.title.squeeze!(" ")
    self.body.squeeze!(" ")
  end

  def set_defaults
    self.view_count ||= 0
  end

  def no_monkey
    if title && title.downcase.include?("monkey")
      errors.add(:title, "No monkey please!")
    end
  end

  def no_title_in_body
    if body.include?(title)
      errors.add(:body, "No title in my body please!")
    end
  end

end
