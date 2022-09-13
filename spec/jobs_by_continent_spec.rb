require 'spec_helper'

RSpec.describe JobsByContinent do
  let(:service) { described_class.new }
  let(:store) { Store.new }
  let(:professions_check) { ProfessionsCheck.new(store) }
  let(:jobs_check) { JobsCheck.new(store) }
  let(:professions_processor) { ProfessionsProcessor.new(store) }
  let(:jobs_processor) { JobsProcessor.new(store) }

  describe 'attributes' do
    it { is_expected.to(have_attr_reader(:store)) }
  end

  describe '#perform' do
    it do
      allow(Store).to receive(:new).and_return(store)

      expect{ service.perform }.to change{ service.store }
        .from(nil).to(store)
    end

    it do
      allow(ProfessionsCheck).to receive(:new).and_return(professions_check)
      allow(JobsCheck).to receive(:new).and_return(jobs_check)
      allow_any_instance_of(ProfessionsCheck).to receive(:perform)
      allow_any_instance_of(JobsCheck).to receive(:perform)
      service.perform

      expect(professions_check).to have_received(:perform).exactly(1).time
      expect(jobs_check).to have_received(:perform).exactly(1).time
    end

    it do
      allow(ProfessionsProcessor).to receive(:new).and_return(professions_processor)
      allow_any_instance_of(ProfessionsProcessor).to receive(:perform)
      service.perform

      expect(professions_processor).to have_received(:perform).exactly(1).time
    end

    it do
      allow(JobsProcessor).to receive(:new).and_return(jobs_processor)
      allow_any_instance_of(JobsProcessor).to receive(:perform)
      service.perform

      expect(jobs_processor).to have_received(:perform).exactly(1).time
    end
  end
end
