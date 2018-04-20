RSpec.describe PetstoreClient::Pet do
  describe '.find' do
    let(:id) { 1 }
    let(:status) { 'available' }
    let(:response_status) { 200 }
    let(:body) { {id: id, status: status}.to_json }
    subject(:pet) { described_class.find(id) }

    before do
      stub_request(:get, "http://petstore.swagger.io/v2/pet/#{id}").with(
        headers: {
          'Accept' => 'application/json',
          'X-Api-Key' => 'token'
        }
      ).to_return(status: response_status, body: body)
    end

    context 'when success' do
      it { expect(pet.id).to eq id }
      it { expect(pet.status).to eq status }
    end

    context 'when error' do
      let(:response_status) { 404 }
      let(:body) { '' }

      it { expect { pet }.to raise_error ActiveResource::ResourceNotFound }
    end
  end

  describe '.find_by_status' do
    let(:id) { 1 }
    let(:statuses) { %w[available pending] }
    let(:response_status) { 200 }
    let(:body) { [{id: id, status: statuses.first}, {id: id + 1, status: statuses.last}].to_json }
    let(:query) { statuses.map { |status| "status=#{status}" }.join('&') }
    subject(:find_by_status) { described_class.find_by_status(statuses) }

    before do
      stub_request(:get, "http://petstore.swagger.io/v2/pet/findByStatus?#{query}").with(
        headers: {
          'Accept' => 'application/json',
          'X-Api-Key' => 'token'
        }
      ).to_return(status: response_status, body: body)
    end

    context 'when success' do
      it { expect(find_by_status.size).to eq 2 }
      it { expect(find_by_status.first.id).to eq id }
      it { expect(find_by_status.first.status).to eq statuses.first }
      it { expect(find_by_status.last.id).to eq id + 1 }
      it { expect(find_by_status.last.status).to eq statuses.last }

      context 'when one status' do
        let(:statuses) { ['available'] }

        it { expect(find_by_status.size).to eq 2 }
        it { expect(find_by_status.first.id).to eq id }
        it { expect(find_by_status.first.status).to eq statuses.first }
        it { expect(find_by_status.last.id).to eq id + 1 }
        it { expect(find_by_status.last.status).to eq statuses.first }
      end

      context 'when without statuses' do
        let(:statuses) { nil }
        let(:body) { [{id: id, status: 'available'}, {id: id + 1, status: 'pending'}].to_json }
        let(:query) { 'status=available&status=pending&status=sold' }

        it { expect(find_by_status.size).to eq 2 }
        it { expect(find_by_status.first.id).to eq id }
        it { expect(find_by_status.first.status).to eq 'available' }
        it { expect(find_by_status.last.id).to eq id + 1 }
        it { expect(find_by_status.last.status).to eq 'pending' }
      end
    end

    context 'when unknown status' do
      let(:statuses) { ['free'] }

      it { expect { find_by_status }.to raise_error ArgumentError }
    end
  end
end
