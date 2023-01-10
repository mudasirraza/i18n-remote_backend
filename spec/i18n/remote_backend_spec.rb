# frozen_string_literal: true

RSpec.describe I18n::Backend::RemoteBackend do
  before do
    I18n.backend = described_class.new
  end
  after do
    described_class.instance_variable_set(:@configuration, nil)
  end

  describe 'translation' do
    context 'remote locale' do
      it 'correctly loads remote locales' do
        described_class.configure { |config| config.http_url = 'http://test-url.com' }
        expect_any_instance_of(described_class::Loader).to receive(:fetch_remote_file).and_return(File.read('spec/fixtures/remote_locales/en.yml'))
        expect(I18n.t('foo')).to eql 'bar'
        expect(I18n.t('test.hello')).to eql 'world'
      end

      it 'raises exception if http_url is not set' do
        expect { I18n.t('foo') }.to raise_error(I18n::Backend::RemoteBackend::BlankURLException)
      end
    end

    context 'local locale' do
      before do
        I18n.backend = I18n::Backend::Chain.new(described_class.new, I18n::Backend::Simple.new)
        I18n.load_path = Dir['spec/fixtures/locales/*.yml']
      end

      it 'fetches local translation if remote translation is not available' do
        described_class.configure { |config| config.http_url = 'http://test-url.com' }
        expect_any_instance_of(described_class::Loader).to receive(:fetch_remote_file).and_return(nil)
        expect(I18n.t('foo')).to eql 'local bar'
      end
    end
  end

  describe 'store_translations' do
    it 'correctly stores translation' do
      store_translations(:en, alphabets: { a: 'a', b: 'b' })
      expect(I18n.t('alphabets.a')).to eql 'a'
    end
  end

  describe 'configuration' do
    it 'raises exception if empty http_url is set' do
      expect do
        described_class.configure do |config|
          config.http_url = nil
        end
      end.to raise_error(described_class::InvalidURLException)
    end

    it 'raises exception if an invalid http_url is set' do
      expect do
        described_class.configure do |config|
          config.http_url = 'not-a-url'
        end
      end.to raise_error(described_class::InvalidURLException)
    end

    it 'correctly sets http_url' do
      described_class.configure { |config| config.http_url = 'http://test-url.com' }
      expect(described_class.configuration.http_url).to eql 'http://test-url.com'
    end
  end
end
