require 'spec_helper'

describe League do
  let(:event) { FactoryBot.create(:event) }
  let(:league) { FactoryBot.create(:league, event: event) }
  let(:person1) { FactoryBot.create(:person) }
  let(:person2) { FactoryBot.create(:person) }
  let(:person3) { FactoryBot.create(:person) }

  before do
    league.person_league_joins.create(person: person1)
    league.person_league_joins.create(person: person2)
    allow(person1).to receive(:up_by).with(event).and_return { 1 }
    allow(person2).to receive(:up_by).with(event).and_return { 3 }
  end

  describe 'associations' do
    it 'belongs to event' do
      expect(league.event.id).to eq event.id
    end

    it 'has many people' do
      expect(league.people).to include person1
      expect(league.people).to include person2
    end
  end

  describe '#participants_by_rank' do
    it 'returns in the right order' do
      expect(league.participants_by_rank).to eq [person2, person1]
    end
  end
end