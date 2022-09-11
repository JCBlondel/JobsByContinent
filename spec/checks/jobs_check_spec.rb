require 'spec_helper'

RSpec.describe JobsCheck do
  describe 'inheritance' do
    it { expect(described_class).to be < FileCheck }
  end

  describe '#perform' do
    let(:store) { Store.new }
    let(:jobs_check) { described_class.new(store) }

    context 'success' do
      it do
        allow(store).to receive(:jobs_csv_file).and_return("spec/fixtures/jobs.csv")

        expect do
          jobs_check.perform
        end.not_to raise_error
      end
    end

    context 'failure' do
      it do
        allow(store).to receive(:jobs_csv_file).and_return("that_does_not_exists")
        error_message = "File 'that_does_not_exists' does not exists."

        expect do
          jobs_check.perform
        end.to raise_error(error_message)
      end

      it do
        allow(store).to receive(:jobs_csv_file).and_return("setup.rb")
        error_message = "File 'setup.rb' has not the .csv extension."

        expect do
          jobs_check.perform
        end.to raise_error(error_message)
      end

      it do
        allow(store).to receive(:jobs_csv_file).and_return("spec/fixtures/professions.csv")
        error_message = "File 'spec/fixtures/professions.csv' has not the required header."

        expect do
          jobs_check.perform
        end.to raise_error(error_message)
      end
    end
  end
end
