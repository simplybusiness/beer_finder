require 'rails_helper'

RSpec.describe Utils do

  context "handling names and serving style" do

    let(:can_text) { 'Gekko can' }
    let(:keg_text) { 'Gekko keg 50L' }
    let(:bottle_text) { 'Tripple Hop Saison' }

    it 'can handle cans' do

      name = Utils.get_beer_name(can_text)
      expect(name).to eql('Gekko')

      is_keg = Utils.is_keg?(can_text)
      expect(is_keg).to be_falsey

      serving_style = Utils.serving_style(can_text)
      expect(serving_style).to eql('can')

    end

    it 'can handle kegs' do

      name = Utils.get_beer_name(keg_text)
      expect(name).to eql('Gekko')

      is_keg = Utils.is_keg?(keg_text)
      expect(is_keg).to be_truthy

      serving_style = Utils.serving_style(keg_text)
      expect(serving_style).to eql('keg')

    end

    it 'can handle bottles' do

      name = Utils.get_beer_name(bottle_text)
      expect(name).to eql('Tripple Hop Saison')

      is_keg = Utils.is_keg?(bottle_text)
      expect(is_keg).to be_falsey

      serving_style = Utils.serving_style(bottle_text)
      expect(serving_style).to eql('can')

    end

  end

  context 'handling distances' do
    let(:sb) { [51.515018, -0.090418] }
    let(:villages) { [51.478605, -0.02474] }


    it 'can handle kms' do
      distance =  Utils.distance_in_km(sb, villages).round
      expect(distance).to eq(6)
    end

    it 'can handle miles' do
      distance =  Utils.distance_in_miles(sb, villages).round
      expect(distance).to eq(4)
    end

  end

end
