describe Onfido do
  subject(:onfido) { described_class }

  context 'configuration' do
    before { onfido.reset }

    describe "default values" do
      describe ".api_key" do
        subject { onfido.api_key }
        it { is_expected.to be_nil }
      end

      describe ".endpoint" do
        subject { onfido.endpoint }
        it { is_expected.to eq('https://api.onfido.com/v1/') }
      end

      describe ".logger" do
        subject { onfido.logger }
        it { is_expected.to be_an_instance_of(Onfido::NullLogger) }
      end
    end

    describe "setting an API key" do
      it 'changes the configuration to the new value' do
        onfido.api_key = 'some_key'
        expect(onfido.api_key).to eq('some_key')
      end
    end

    describe '.logger' do
      context 'when an option is passed' do
        context 'when the option passed behaves like a logger' do
          let(:logger_like) { double('LoggerLike', :<< => nil) }

          it 'returns the option' do
            onfido.logger = logger_like
            expect(onfido.logger).to eq(logger_like)
          end
        end

        context 'when the option passed does not behave like a logger' do
          let(:non_logger) { double('NotLogger') }

          it 'raises an error' do
            expect { onfido.logger = non_logger }.
              to raise_error(
                "#{non_logger.class} doesn't seem to behave like a logger!"
              )
          end
        end
      end
    end
  end
end
