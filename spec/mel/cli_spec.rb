RSpec.describe Mel::CLI do
  let(:help) do
    <<-EOS
Commands:
  #{command} help [COMMAND]          # Describe available commands or one specific command
  #{command} list -f, --file=FILE    # Display list of methods
  #{command} version, -v, --version  # Print the version

    EOS
  end

  shared_examples_for 'a `list` command with full options' do
    let(:string_mock) { instance_double('string') }

    before do
      expect(File).to receive_message_chain(:open, :read).with('test.rb', 'r').with(no_args).and_return(string_mock)
      expect(Mel::Parser).to receive(:parse).with(string_mock)
    end

    it { is_expected.not_to output.to_stdout }
  end

  shared_examples_for 'a `help` command' do
    before do
      expect(File).to receive(:basename).with($PROGRAM_NAME).and_return(command).at_least(:once)
    end

    it { is_expected.to output(help).to_stdout }
  end

  describe '.start' do
    let(:command) { 'mel' }

    subject { -> { described_class.start(thor_args) } }

    context 'given `list -f target.rb`' do
      let(:thor_args) { %w[list -f target.rb] }
      it_behaves_like 'a `list` command with full options'
    end

    context 'given `list --file target.rb`' do
      let(:thor_args) { %w[list --file target.rb] }
      it_behaves_like 'a `list` command with full options'
    end

    context 'given `list`' do
      let(:thor_args) { %w[list] }
      it { is_expected.to output("No value provided for required options '--file'\n").to_stderr }
    end

    context 'given ``' do
      let(:thor_args) { %w[] }
      it { is_expected.to output("No value provided for required options '--file'\n").to_stderr }
    end

    context 'given `version`' do
      let(:thor_args) { %w[version] }
      it { is_expected.to output("#{command} #{Mel::VERSION}\n").to_stdout }
    end

    context 'given `--version`' do
      let(:thor_args) { %w[--version] }
      it { is_expected.to output("#{command} #{Mel::VERSION}\n").to_stdout }
    end

    context 'given `-v`' do
      let(:thor_args) { %w[-v] }
      it { is_expected.to output("#{command} #{Mel::VERSION}\n").to_stdout }
    end

    context 'given `help`' do
      let(:thor_args) { %w[help] }
      it_behaves_like 'a `help` command'
    end

    context 'given `--help`' do
      let(:thor_args) { %w[--help] }
      it_behaves_like 'a `help` command'
    end

    context 'given `-h`' do
      let(:thor_args) { %w[-h] }
      it_behaves_like 'a `help` command'
    end

    context 'given `h`' do
      let(:thor_args) { %w[h] }
      it_behaves_like 'a `help` command'
    end

    context 'given `he`' do
      let(:thor_args) { %w[he] }
      it_behaves_like 'a `help` command'
    end

    context 'given `hel`' do
      let(:thor_args) { %w[hel] }
      it_behaves_like 'a `help` command'
    end

    context 'given `help list`' do
      let(:thor_args) { %w[help list] }
      let(:help) do
        <<-EOS
Usage:
  #{command} list -f, --file=FILE

Options:
  -f, --file=FILE  

Display list of methods
        EOS
      end
      it_behaves_like 'a `help` command'
    end

    context 'given `help version`' do
      let(:thor_args) { %w[help version] }
      let(:help) do
        <<-EOS
Usage:
  #{command} version, -v, --version

Print the version
        EOS
      end
      it_behaves_like 'a `help` command'
    end

    context 'given `help help`' do
      let(:thor_args) { %w[help help] }
      let(:help) do
        <<-EOS
Usage:
  #{command} help [COMMAND]

Describe available commands or one specific command
        EOS
      end
      it_behaves_like 'a `help` command'
    end

    context 'given `abc`' do
      let(:thor_args) { %w[abc] }
      it { is_expected.to output(%(Could not find command "abc".\n)).to_stderr }
    end

    context 'given `helpp`' do
      let(:thor_args) { %w[helpp] }
      it { is_expected.to output(%(Could not find command "helpp".\n)).to_stderr }
    end
  end
end
