
import UIKit
import Kingfisher

class NewsCell: UICollectionViewCell {
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4

        contentView.addSubview(newsImageView)
        contentView.addSubview(stackView)

        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.heightAnchor.constraint(equalToConstant: 80),

            stackView.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with article: NewsArticle) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            newsImageView.kf.setImage(with: url)
        } else {
            newsImageView.image = UIImage(named: "placeholder")
        }
    }
}
