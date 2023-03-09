// SPDX-License-Identifier: GPL-2.0

/*
 * MEC1705 eSPI Controller Driver
 */
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_platform.h>
#include <linux/of_address.h>
#include <linux/platform_device.h>
#include <linux/ioport.h>

/*
 * struct mec1705_espi (MEC1705 Intel Enhanced Serial Peripheral Interface)
 *
 * @regs - Store base virtual address for MEC1705 eSPI interface
 */
struct mec1705_espi {
	void __iomem *regs;
};

static int mec1705_espi_probe(struct platform_device *mec1705)
{
	struct mec1705_espi *mec1705_espi;
	struct device *dev = &mec1705->dev;

	const char *compatible_propery;
	device_property_read_string(dev, "compatible", &compatible_propery);
	dev_warn(dev, "compatible: %s", compatible_propery);

	/* Per device structure allocation */
	mec1705_espi = devm_kzalloc(dev, sizeof(*mec1705_espi), GFP_KERNEL);
	if (!mec1705_espi)
		return -ENOMEM;

	/* Get a virtual address for the device registers */
	mec1705_espi->regs = devm_platform_ioremap_resource(mec1705, 0);
	if (IS_ERR(mec1705_espi->regs))
		return PTR_ERR(mec1705_espi->regs);

	dev_set_drvdata(dev, mec1705_espi);

	return 0;
}

static int mec1705_espi_remove(struct platform_device *mec1705)
{
	dev_warn(&mec1705->dev, "ENTER mec1705_espi_remove function driver bound to ACPI table");
	return 0;
}

static const struct of_device_id of_mec1705_espi_match[] = {
	{ .compatible = "microchip,mec1705-espi" },
	{}
};

MODULE_DEVICE_TABLE(of, of_mec1705_espi_match);

static const struct platform_device_id mec1705_platform_devid[] = {
	{ "mec1705-espi", 0 },
	{ }
};

static struct platform_driver mec1705_espi_driver = {
	.driver = {
		.name = "mec1705_espi",
		.of_match_table = of_mec1705_espi_match,
	},
	.id_table   = mec1705_platform_devid,
	.probe      = mec1705_espi_probe,
	.remove	    = mec1705_espi_remove,
};

module_platform_driver(mec1705_espi_driver);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Vincent Davis (vince@underview.tech)");
MODULE_DESCRIPTION("Microchip MEC1705 eSPI Controller Driver");
