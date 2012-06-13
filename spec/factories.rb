FactoryGirl.define do
	factory :user do
		#sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
		  admin true
		end
	end

	factory :bar do
		sequence(:name) { |n| "Bar #{n}" }
		sequence(:email) { |n| "bar_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"
		neighborhood "Alphabet City"
		sequence(:address) { |n| "#{n} Example St." }
		sequence(:phone) { |n| "#{n}"*10  }
	end
end