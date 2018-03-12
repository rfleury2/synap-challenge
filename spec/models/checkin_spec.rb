require 'spec_helper'

describe Checkin do
  let(:person) { FactoryBot.create(:person) }
  let(:event) { FactoryBot.create(:event) }
  let(:checkin) { FactoryBot.create(:checkin, event: event, person: person) }

  before { checkin }

  describe 'associations' do
    it 'belongs to event' do
      expect(checkin.event.id).to eq event.id
    end

    it 'belongs to person' do
      expect(checkin.person.id).to eq person.id
    end
  end

  describe '.for_event' do
    let!(:checkin2) { FactoryBot.create(:checkin) }
    let!(:checkin3) { FactoryBot.create(:checkin, event: event) }
    subject { Checkin.for_event(event) }

    it 'returns checkins for a given event' do
      expect(subject).to include checkin
      expect(subject).to include checkin3
      expect(subject).to_not include checkin2
    end
  end
end
